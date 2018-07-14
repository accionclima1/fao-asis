require 'sidekiq-scheduler'

class UpdateFilesDatabaseWorker
  include Sidekiq::Worker

  def perform(*args)
    FilesService.call
  end
end
