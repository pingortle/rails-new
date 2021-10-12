def source_paths
  [__dir__]
end

directory "lib"

if (app_layout_path = Rails.root.join("app/views/layouts/application.html.erb")).exist?
  mvp_css = "https://unpkg.com/mvp.css"
  say "Add stylesheet link tag in application layout"
  insert_into_file(
    app_layout_path.to_s,
    defined?(Turbo) ?
      %(\n    <%= stylesheet_link_tag "#{mvp_css}", "data-turbo-track": "reload" %>) :
      %(\n    <%= stylesheet_link_tag "#{mvp_css}" %>),
    before: /\n *<%= stylesheet_link_tag "application"/
  )
else
  say "Default application.html.erb is missing!", :red
  if defined?(Turbo)
    say %(        Add <%= stylesheet_link_tag "#{mvp_css}", "data-turbo-track": "reload" %> within the <head> tag in your custom layout.)
  else
    say %(        Add <%= stylesheet_link_tag "#{mvp_css}" %> within the <head> tag in your custom layout.)
  end
end
