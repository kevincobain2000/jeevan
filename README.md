### Rakes

```
rake db:schema:load
```

### Erb

```
<%= image_tag("about_slide1.jpg") %> # Looks assets/images/about_slide1.jpg
```


#### typeahead twitter

```
<%= text_field_tag :sex, nil, class: 'typeahead tt', placeholder:'sex' %>
```

and its coffee

```
$(document).ready ->
  $(".typeahead").typeahead
    name: "planets"
    local: ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]


```