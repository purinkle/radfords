class OutletsPage
  include Capybara::DSL
  include Capybara::Node::Matchers
  include RSpec::Matchers

  def delete_supplier
    click_button "Delete"
  end

  def create_supplier
    click_link "New"
  end

  def edit_supplier
    click_link "Edit"
  end
end
