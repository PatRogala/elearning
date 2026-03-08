module Avo
  module Resources
    # Role resource for admin
    class Role < Avo::BaseResource
      self.title = :name
      self.includes = [:users]
      # self.attachments = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :name, as: :text, required: true
        field :users, as: :has_many, view_type: :list, link_to_resource: true
      end
    end
  end
end
