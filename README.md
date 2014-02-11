### Rakes

```
rake db:schema:load
```

### Erb

```
<%= image_tag("about_slide1.jpg") %> # Looks assets/images/about_slide1.jpg
```

#### Selectize

```
<select id="select-movie" name="movie" value="Other" class="selectized"/>
```

name: movie is the column name in db
value:Other is the default value shown or the value taken from DB that user set last time

Use Input if there are maxItems and create:true

```
<input id="select-movie" name="movie" value="Other" class="selectized">
```




#### AJAX

```
<%= form_tag({:action=>'modify'}, {:remote => true}) do %>
```

Works even with turbolinks



#### Scratch

