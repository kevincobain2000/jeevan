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
<select id="select-movie" name="movie" value="Other" class="selectized"></select>
```

name: movie is the column name in db
value:Other is the default value shown or the value taken from DB that user set last time


#### AJAX

```
<%= form_tag({:action=>'modify'}, {:remote => true}) do %>
```

Works even with turbolinks



#### Scratch

```
  select_best_time_f[0].selectize.setValue([$("#select-best-time-f").attr('value')])
  select_best_time_t[0].selectize.setValue([$("#select-best-time-t").attr('value')])

  # These values are loaded from DB
  select_religion[0].selectize.setValue([$("#select-religion").attr('value')])
  select_mother_tongue[0].selectize.setValue([$("#select-mother-tongue").attr('value')])
  select_caste[0].selectize.setValue([$("#select-caste").attr('value')])
  select_sub_caste[0].selectize.setValue([$("#select-sub-caste").attr('value')])
  select_native_place[0].selectize.setValue([$("#select-native-place").attr('value')])

  # select_birth_country[0].selectize.setValue([$("#select-birth-country").attr('value')])
  # select_birth_city[0].selectize.setValue([$("#select-birth-city").attr('value')])
  # select_tob[0].selectize.setValue([$("#select-tob").attr('value')])
  # select_manglik[0].selectize.setValue([$("#select-manglik").attr('value')])
  # select_sun_sign[0].selectize.setValue([$("#select-sun-sign").attr('value')])
  # select_moon_sign[0].selectize.setValue([$("#select-moon-sign").attr('value')])
  # select_nakshatra[0].selectize.setValue([$("#select-nakshatra").attr('value')])

  select_hobby[0].selectize.setValue($("#select-hobby").attr('value').split(","))
  select_music[0].selectize.setValue($("#select-music").attr('value').split(","))
  select_interest[0].selectize.setValue($("#select-interest").attr('value').split(","))
  select_read[0].selectize.setValue($("#select-read").attr('value').split(","))
  select_dress[0].selectize.setValue($("#select-dress").attr('value').split(","))
  select_tv[0].selectize.setValue($("#select-tv").attr('value').split(","))
  select_movie[0].selectize.setValue($("#select-movie").attr('value').split(","))
  select_sport[0].selectize.setValue($("#select-sport").attr('value').split(","))
  select_cuisine[0].selectize.setValue($("#select-cuisine").attr('value').split(","))
  select_vacation[0].selectize.setValue($("#select-vacation").attr('value').split(","))
```