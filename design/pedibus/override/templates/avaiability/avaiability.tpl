{set-block scope=root variable=cache_ttl}0{/set-block}
<style>
{literal}
    body {
        margin: 40px 10px;
        padding: 0;
        font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
        font-size: 14px;
    }

    #pedibuscalendar
    {
        max-width: 900px;
        margin: 0 auto;
        padding: 0 10px;
    }
{/literal}
</style>

<script type="text/javascript">
{literal}
    document.addEventListener("DOMContentLoaded", function()
    {
        (function ($)
        {
            $(document).ready(function ()
            {
                $.post("/ilpedibus_ajax/availability", {}).done(function( data )
                {
                    console.log( "LENGTH == " + data.length );

                    if( data.length )
                    {
                        $('#pedibuscalendar').fullCalendar(
                        {
                            header: {
                                left: 'prev,next today',
                                center: 'title',
                                right: 'month,agendaWeek,agendaDay,listMonth'
                            },
                        {/literal}
                            defaultDate: '{currentdate()|datetime('custom', '%Y-%m-%d')}',
                        {literal}
                            buttonIcons: true,
                            weekNumbers: false,
                            navLinks: true,
                            editable: false,
                            eventLimit: false,
                            events: data,
                            eventRender: function(event, eventElement)
                            {
                                if(event.title.toLowerCase().indexOf(" verde ") > 0)
                                {
                                    eventElement.addClass('green');
                                }

                                if(event.title.toLowerCase().indexOf(" blu ") > 0)
                                {
                                    eventElement.addClass('blue');
                                }

                                if(event.title.toLowerCase().indexOf(" rossa ") > 0)
                                {
                                    eventElement.addClass('red');
                                }

                                if(event.title.toLowerCase().indexOf(" gialla ") > 0)
                                {
                                    eventElement.addClass('yellow');
                                }
                            }
                        });
                    }

                });
            });
        })(jQuery);
    });
{/literal}
</script>
<div id='pedibuscalendar'></div>
{undef}
