namespace :sync do
  desc 'Run the crawler in Recrod::Mover mode'
  task :mover, [:from_bucket, :to_bucket] => :environment do |_task, args|
    Redis::List.new('visited').clear
    Syncer::Mover.perform_async args.from_bucket, args.to_bucket
  end

  desc 'Run the crawler in Recrod::Rescreener mode'
  task :rescreener, [:bucket] => :environment do |_task, args|
    Redis::List.new('visited').clear
    Syncer::Rescreener.perform_async args.bucket
  end

  desc 'Run the crawler in Recrod::Rescrimper mode'
  task :rescrimper, [:bucket] => :environment do |_task, args|
    Redis::List.new('visited').clear
    Syncer::Rescrimper.perform_async args.bucket
  end

  desc 'Run the crawler in Recrod::Resampler mode'
  task :resampler, [:bucket] => :environment do |_task, args|
    Redis::List.new('visited').clear
    Syncer::Resampler.perform_async args.bucket
  end

  desc 'Run the crawler in Recrod::Respider mode'
  task :respider, [:bucket] => :environment do |_task, args|
    Redis::List.new('visited').clear
    Syncer::Respider.perform_async args.bucket
  end
end
