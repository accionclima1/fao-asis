require 'net/ssh'
class FilesService 
    include Callable 

    def initialize(args={})
        @server_ip = '51.15.142.103'
        @server_user = 'root'
        @dir_name = 'last_indices'
        @inner_folders = %w{ ASt  ASy  DEF  MRt  MRy  PEy }
        @key_file = 'perspectivaSW.key'
        @server_root_path = '/root/ASIS/CENTROAMERICA'
        @ftp_server_root_path = 'ASIS/CENTROAMERICA'
        @server_sub_path = 'SALIDA/QLK/VHt'
    end

    def call 
        file_names = {}
        Dir.mkdir(Rails.root.join("public", @dir_name)) unless File.exists?(Rails.root.join("public", @dir_name))
        FileUtils.rm_rf Dir.glob(Rails.root.join("public/#{@dir_name}", '*'))
        Net::SSH.start(@server_ip, @server_user, passphrase: 'sigma541', keys: [Rails.root.join("config", @key_file)], keys_only: true) do |ssh|
            @inner_folders.each do |folder|
                 file_name = (ssh.exec! "ls -t #{@server_root_path}/#{@server_sub_path}/#{folder} | head -1")
                 file_names[folder] = file_name unless file_name.empty? 
            end
        end

        Net::SFTP.start(@server_ip, @server_user, passphrase: 'sigma541', keys: [Rails.root.join("config", @key_file)]) do |sftp|
            @inner_folders.each do |folder|
                file_name = file_names[folder]
                if file_name
                    file_name = file_name.sub(/\n/, '')
                    local_io = File.new(Rails.root.join("public", @dir_name, file_name), mode: 'wb')
                    sftp.download!("#{@ftp_server_root_path}/#{@server_sub_path}/#{folder}/#{file_name}", local_io)
                end
            end
        end
    end

    private 

    attr_reader :server_ip, :server_user, :key_file, :dir_name, :inner_folders, :server_root_path, :server_sub_path
end