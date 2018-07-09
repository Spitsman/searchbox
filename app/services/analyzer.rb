class Analyzer
  class << self
    def add(ip, text)
      redis.rpush("analytics-#{ip}", text)
    end

    def get_analytics # выбираю самый длинный запрос для каждого ip
      all_requests = keys.map{ |key| $redis.lrange(key, 0, -1) }
      max_lenght_requests = all_requests.map{ |ary| ary.max_by(&:length) }
      max_lenght_requests.inject(Hash.new(0)) { |total, e| total[e] += 1; total}
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