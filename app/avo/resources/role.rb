module Avo
  module Resources
    # Role resource for admin
    class Role < Avo::BaseResource
      # self.includes = []
      # self.attachments = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :name, as: :text
      end
    end
  end
end
