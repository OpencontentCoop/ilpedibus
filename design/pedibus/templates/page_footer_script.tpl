{if ezini('GeneralSettings','SocialButtons', 'openpa.ini')|eq('enabled')}
  <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid={ezini('GeneralSettings','SocialPubId', 'openpa.ini')}"></script>
{/if}

<!--[if IE 8]>
<script src="{'javascript/vendor/respond.min.js'|ezdesign(no)}"></script>
<script src="{'javascript/vendor/rem.min.js'|ezdesign(no)}"></script>
<script src="{'javascript/vendor/selectivizr.js'|ezdesign(no)}"></script>
<script src="{'javascript/vendor/slice.js'|ezdesign(no)}"></script>
<![endif]-->

<!--[if lte IE 9]>
<script src="{'javascript/vendor/polyfill.min.js'|ezdesign(no)}"></script>
<![endif]-->

<script src="{'javascript/IWT.min.js'|ezdesign(no)}"></script>

{if openpaini( 'Seo', 'GoogleAnalyticsAccountID', false() )}
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', '{openpaini( 'Seo', 'GoogleAnalyticsAccountID' )}']);
  _gaq.push(['_setAllowLinker', true]);
  _gaq.push(['_trackPageview']);
  (function() {ldelim}
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  {rdelim})();
</script>
{/if}

{*********************
   Interline Pedibus
**********************}
{*<!-- ===== include jQuery library ===== -->*}
<script type="text/javascript" src="{'javascript/jquery-3.2.1.min.js'|ezdesign(no)}"></script>
<script type="text/javascript">window.jQuery || document.write('<script src="https://code.jquery.com/jquery-3.2.1.min.js"><\/script>')</script>

{*<!-- ===== include Bootstrap ===== -->*}
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

{*<!-- ===== IE10 viewport hack for Surface/desktop Windows 8 bug ===== -->*}
<script src="{'javascript/ie10-viewport-bug-workaround.js'|ezdesign(no)}"></script>

{*<!-- ===== Magnific-Popup ===== -->*}
<script type="text/javascript" src="{'javascript/Magnific-Popup/dist/jquery.magnific-popup.min.js'|ezdesign(no)}"></script>

<script type="text/javascript" src="{'javascript/moment-with-locales.min.js'|ezdesign(no)}"></script>
<script type="text/javascript" src="{'javascript/bootstrap-datetimepicker.min.js'|ezdesign(no)}"></script>


<script src="{'javascript/fullcalendar/lib/moment.min.js'|ezdesign(no)}"></script>
{*<script src="{'javascript/pedibuscalendar/lib/jquery.min.js'|ezdesign(no)}"></script>*}
<script src="{'javascript/fullcalendar/fullcalendar.min.js'|ezdesign(no)}"></script>
<script src="{'javascript/fullcalendar/locale/it.js'|ezdesign(no)}"></script>


<script type="text/javascript">
{literal}
    document.addEventListener("DOMContentLoaded", function()
    {
        (function ($) {
            var dd = $('.dropdown-toggle').parent();
            dd.hover(function(){
                if(($(window).innerWidth())>=1200)
                {
                    $(this).addClass('open');
                }
            }, function() {
                if(($(window).innerWidth())>=1200)
                {
                    $(this).removeClass('open');
                }
            });

            function calcPadd(){
                var h_nav = $( "nav" ).outerHeight();
                var t_nav = $( ".top-nav" ).outerHeight();
                var px_push = h_nav + t_nav;
                $("body").css('padding-top', px_push);
            }

            calcPadd();

            $(window).resize(function(){
                calcPadd();
            });

            $('.popup-youtube').magnificPopup({
                disableOn: 700,
                type: 'iframe',
                mainClass: 'mfp-fade',
                removalDelay: 160,
                preloader: false,

                fixedContentPos: false
            });

            $('.gallery div').magnificPopup({
                delegate: 'a',
                type:'image',
                removalDelay: 300,
                mainClass: 'mfp-fade',

                gallery:{enabled:true}
            });

        })(jQuery);
    });
{/literal}
</script>