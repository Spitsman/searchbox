class Analyzer
  class << self
    def add(ip, text)
      redis.rpush("analytics-#{ip}", text)
    end

    def get_analytics
      all_requests = keys.map{ |key| $redis.lrange(key, 0, -1) } # беру все запросы от разных ip

      result = all_requests.map do |requests_for_ip| # для каждого ip удаляю запросы которые являются подстрокой других запросов
        uniq_request_for_ip = requests_for_ip.uniq

        uniq_request_for_ip.each do |el|
          uniq_request_for_ip.each do |el2|
            requests_for_ip.delete(el2) if el.include?(el2) && el != el2
          end
        end

        requests_for_ip
      end

      result.flatten
        .inject(Hash.new(0)) { |total, e| total[e] += 1; total}
        .sort_by { |request, count| count }
        .reverse.to_h # считаю сколько раз встретился каждый запрос
    end

    def destroy_all
      keys.each { |key| redis.del(key) }
    end

    protected

    def keys
      redis.keys.grep /analytics/
    end

    def redis
      $redis
    end
  end
end