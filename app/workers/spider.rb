class Spider < Creeper
  sidekiq_options queue: :spider,
                  retry: true,
                  backtrace: true,
                  unique: true,
                  unique_job_expiration: 24 * 60 * 60

  def perform url
    @url = url
    parser.page = scraper.get
    visit.spider
    upload
  rescue Net::HTTP::Persistent::Error
    Spider.perform_async @url
  end

  def visit
    @visit ||= Visit.new(parser.internal_links)
  end
end
