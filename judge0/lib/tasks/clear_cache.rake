desc "Clear cache."

namespace :judge0 do
  task :clear_cache => :environment do
    Rails.cache.clear
  end
end