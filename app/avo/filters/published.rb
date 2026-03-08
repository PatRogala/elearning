module Avo
  module Filters
    # Show only published resources
    class Published < Avo::Filters::BooleanFilter
      def apply(_request, query, values)
        return query if values["is_published"] && values["is_unpublished"]

        if values["is_published"]
          query = query.published
        elsif values["is_unpublished"]
          query = query.unpublished
        end

        query
      end

      def options
        {
          is_published: I18n.t("avo.filter.published.options.is_published"),
          is_unpublished: I18n.t("avo.filter.published.options.is_unpublished")
        }
      end
    end
  end
end
