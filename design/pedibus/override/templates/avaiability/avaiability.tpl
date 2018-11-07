{ezpagedata_set('has_container',  true())}
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
                $.post({/literal}"{'/ilpedibus_ajax/availability'|ezurl(no)}{literal}", {}).done(function( data )
                {
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
                                $('#loader').hide();
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
<div id='pedibuscalendar'>
    <p class="text-center" id="loader"><i class="fa fa-circle-o-notch fa-spin fa-3x fa-fw"></i></p>
</div>
{undef}
