module Avo
  module Resources
    # Lesson resource for admin
    class Lesson < Avo::BaseResource
      self.title = :title
      self.includes = [:course]
      # self.attachments = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
      end
    end
  end
end
