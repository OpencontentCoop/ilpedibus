{* https://github.com/blueimp/Gallery vedi atom/gallery.tpl *}
<div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls" style="display:none;">
  <div class="slides"></div>
  <h3 class="title"><span class="sr-only">gallery</span></h3>
  <a class="prev">‹</a>
  <a class="next">›</a>
  <a class="close">×</a>
  <a class="play-pause"></a>
  <ol class="indicator"></ol>
</div>

{* modal window and AJAX stuff *}
<div id="overlay-mask" style="display:none;"></div>
<img src={'loader.gif'|ezimage()} id="ajaxuploader-loader" style="display:none;" alt="{'Loading...'|i18n( 'design/admin/pagelayout' )}" />
