class JsonPagination
  include Rails.application.routes.url_helpers
  attr_reader :scope, :url_method, :page_number, :page_size

  def initialize(scope:, page_number:, url_method:, page_size: 10)
    @scope = scope
    @url_method = url_method
    @page_size = page_size.to_i
    @page_number = page_number.to_i
  end

  def paginate
    {
      links: {
        first: send(url_method, page: { size: page_size, number: 1 })
      },
      meta: {
        page_count: page_count,
        total: scope_count
      }
    }.tap do |pagination|
      pagination[:links][:last] = links_last if links_last
      pagination[:links][:next] = links_next if links_next
    end
  end

  def links_last
    send(url_method, page: { size: page_size, number: page_count })
  end

  def links_next
    return if page_number == page_count
    send(url_method, page: { size: page_size, number: page_number + 1})
  end

  def page_count
    (scope_count / page_size.to_f).ceil
  end

  def scope_count
    @scope_count ||= @scope.count
  end

  def self.paginate(**args)
    new(**args).paginate
  end
end
