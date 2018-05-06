class PaginationService

  attr_reader :page, :per_page

  def initialize(params)
    params = params.try(:deep_symbolize_keys) || params.deep_dup

    @page     = params[:page]    .try(:to_i) || 1
    @per_page = params[:per_page].try(:to_i) || 20
  end

  def has_invalid_page?
    @page <= 0
  end

  def has_invalid_per_page?
    @per_page <= 0
  end

  def paginate(model, serializer, serializer_options)
    paginated_resource = model.paginate(page: page, per_page: per_page)

    serializable_resources = ActiveModelSerializers::SerializableResource.new(
      paginated_resource,
      {
        each_serializer: serializer
      }.merge(serializer_options)
    )

    {
      model.name.underscore.pluralize.to_sym => serializable_resources.as_json,
      meta:                           self.class.pagination_dict(paginated_resource)
    }
  end

  private

  def self.pagination_dict(paginated_resource)
    {
      current_page: paginated_resource.current_page,
      next_page:    paginated_resource.next_page,
      prev_page:    paginated_resource.previous_page,
      total_pages:  paginated_resource.total_pages,
      total_count:  paginated_resource.total_entries
    }
  end
end