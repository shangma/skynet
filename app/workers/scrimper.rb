class Scrimper < Creeper
  sidekiq_options queue: :scrimper,
                  retry: true,
                  backtrace: true,
                  unique: true,
                  unique_job_expiration: 24 * 60 * 60

  def perform url
    @url = url
    parser.page = scraper.get
    upload
  rescue Net::HTTP::Persistent::Error
    Scrimper.perform_async @url
  end
end
