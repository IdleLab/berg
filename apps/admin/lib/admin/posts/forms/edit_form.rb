require "berg/form"

module Admin
  module Posts
    module Forms
      class EditForm < Berg::Form
        include Admin::Import[
          "admin.persistence.repositories.people",
          "admin.persistence.repositories.categories"
        ]

        prefix :post

        define do
          section :post do
            group do
              text_field :title, label: "Title"
              text_field :slug, label: "Slug"
            end
            group do
              text_area :teaser, label: "Teaser"
              selection_field :person_id, label: "Author", options: dep(:author_list)
            end

            text_area :body, label: "Body"

            group do
              select_box :status, label: "Status", options: dep(:status_list)
              date_time_field :published_at, label: "Published at"
            end
            multi_selection_field :post_categories,
              label: "Categories",
              selector_label: "Choose categories",
              options: dep(:categories_list)
          end
        end

        def author_list
          people.all_people.map { |person| { id: person.id, label: person.name } }
        end

        def status_list
          Entities::Post::Status.values.map { |value| [value, value.capitalize] }
        end

        def categories_list
          categories.listing.to_a.map { |category|
            {
              id: category.id,
              label: category.name,
              slug: category.slug
            }
          }
        end
      end
    end
  end
end
