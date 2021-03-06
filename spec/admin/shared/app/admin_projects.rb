require "babosa"

RSpec.shared_context "admin projects" do
  def create_project(title, attrs = {})
    Admin::Container["admin.projects.operations.create"].({
      "title" => title,
      "client" => "An example client",
      "url" => "http://example.com",
      "intro" => "Intro text for this example project",
      "summary" => "Summary text for this example project",
      "body" => "Body content for this example project",
      "slug" => title.to_slug.normalize.to_s,
      "case_study" => false,
      "cover_image" => nil,
      "assets" => []
    }.merge(attrs)).value
  end

  let!(:sample_project) { create_project("An Example Project") }
end
