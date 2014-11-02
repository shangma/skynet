class Recorder::Base < Worker
  sidekiq_options queue: :recorder,
                  retry: true,
                  backtrace: true,
                  unique: true,
                  unique_job_expiration: 24 * 60 * 60

  def cloud
    @cloud ||= Cloud.new(@container)
  end

  def records
    @records ||= cloud.files
  end

  def record record
    Record::Base.new(@container, record)
  end
end