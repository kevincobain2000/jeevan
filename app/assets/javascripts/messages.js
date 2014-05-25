$(document).change(function() {

    // Although js is put here but the button is in profiles/id
   // $('form.message_form').bind("keyup change", function(e) {
       // $(this).find(':submit').removeClass('disabled');
    // });

    // $('#message_button').click(function() {
        // console.log("This");
        // $.gritter.add({ image: $(this).data("img"), title: 'Message Sent', text: 'We have notified the recipient' });
        // message = $("#message_textarea").val()
        // $("#chat-body").append(message)
        // $(this).children('#message_textarea').text("");
    // });

    /*===============================
    =            SOCKETS            =
    ===============================*/

    events_datetime = [];
    PrivatePub.subscribe("/messages/messages/"+$("#user").data("id"), function(data, channel) {
        dt = data.data

        if ($.inArray(dt.datetime, events_datetime) !== -1) {
          return;
      };

      events_datetime.push(dt.datetime);
      $.gritter.add({ image: dt.img, title: dt.title, text: '<a class="txt-color-white" href="/messages/'+dt.profile_id+'">view profile</a>' });
    });
    /*-----  End of SOCKETS  ------*/


});
