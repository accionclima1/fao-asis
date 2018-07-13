namespace :files do 
    desc 'Download files from the server using ssh'
    task :get_last_indices => :environment do 
        FilesService.call
    end
end