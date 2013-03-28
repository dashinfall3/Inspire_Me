class MuralsWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform()
    inspiration = Inspiration.current_master_inspiration
    User.all.each do |user|
      Notifier.daily_mural_email(user, inspiration).deliver
    end
  end
end