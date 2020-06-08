# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'avatars/new', type: :view do
  before do
    assign(:avatar, Avatar.new)
  end

  it 'renders new avatar form' do
    render

    assert_select 'form[action=?][method=?]', avatars_path, 'post' do
    end
  end
end
