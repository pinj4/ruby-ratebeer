module ApplicationHelper
  include ActionView::Helpers::NumberHelper

  def edit_and_destroy_buttons(item)
    return if current_user.nil?

    edit = link_to('Edit', url_for([:edit, item]), class: "btn btn-primary")

    if current_user.admin
      del = link_to('Destroy', item, method: :delete,
                                     data: { confirm: "Are you sure ?" },
                                     class: "btn btn-danger")
    end
    raw("#{edit} #{del}")
  end

  def round(number)
    number_with_precision(number, precision: 1)
  end
end
