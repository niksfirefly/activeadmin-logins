require 'geoip'
require 'sidekiq'

class UserLoginWorker
  include Sidekiq::Worker

  def perform(user_id, ip, user_agent)
    user = AdminUser.find(user_id)

    geo_ip_city = geo_ip.city(ip)

    country, city = nil, nil
    if geo_ip_city
      country = geo_ip_city.country_name
      city = geo_ip_city.city_name
    end

    UserLogin.create! user: user, user_agent: user_agent, ip: ip, country: country, city: city
  end

  private

  def geo_ip
    GeoIP.new Gem.find_files("**/GeoLiteCity.dat").first
  end
end
