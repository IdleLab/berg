require "berg/form"

module Admin
  module Projects
    module Forms
      class EditForm < Berg::Form
        include Admin::Import["admin.persistence.repositories.projects"]

        prefix :project

        define do
          text_field :title,
            label: "Title",
            validation: {
              filled: true
            }
          text_field :client,
            label: "Client",
            validation: {
              filled: true
            }
          text_field :url,
            label: "URL",
            validation: {
              filled: true
            }
          text_area :intro,
            label: "Introduction",
            validation: {
              filled: true
            }
          text_area :body,
            label: "Body",
            validation: {
              filled: true
            }
          text_field :slug,
            label: "Slug",
            validation: {
              filled: true
            }
          text_field :tags,
            label: "Tags",
            validation: {
              filled: true
            }
          select_box :status,
            label: "Status", options: [
              ["draft", "Draft"], ["published", "Published"], ["deleted", "Deleted"]
          ]
          date_time_field :published_at, label: "Published at"
          check_box :case_study, label: "Case Study", question_text: "Mark as a Case Study?"
        end
      end
    end
  end
end
