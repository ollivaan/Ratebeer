require 'rails_helper'

RSpec.describe "styles/show", type: :view do
  before(:each) do
    @style = assign(:style, Style.create!(
      :style => "Style"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Style/)
  end
end
