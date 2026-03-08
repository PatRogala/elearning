module Avo
  module Resources
    # Resource for Course
    class Course < Avo::BaseResource
      self.title = :title
      self.includes = [:instructor]
      self.attachments = [:image]
      # self.search = {
      #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
        field :title, as: :text, required: true
        field :description, as: :trix
        field :image, as: :file, accepts: "image/*"
        field :price, as_money: {
          currency: "PLN"
        }, required: true
        field :published, as: :boolean
        field :instructor, as: :belongs_to, link_to_resource: true
        field :lessons, as: :has_many, view_type: :list
      end

      def filters
        filter Avo::Filters::Published
      end
    end
  end
end
