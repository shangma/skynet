class Crawler::Slider < Crawler::Base
  sidekiq_options queue: :slider,
                  retry: true,
                  backtrace: true,
                  unique: true,
                  unique_job_expiration: 24 * 60 * 60

  def perform(url)
    @url = url
    parser.page = scraper.get
    upload
  rescue Net::HTTP::Persistent::Error
    Crawler::Slider.perform_async @url
  end

  def upload
    Recorder::Uploader.perform_async parsed.merge(social.shares) if exists?
  end
end
