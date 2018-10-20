<div class="Header-navbar">
  <div class="u-layout-wide Grid Grid--alignMiddle u-layoutCenter">


{*    {include uri='design:header/logo.tpl'}*}

    {if $pagedata.is_login_page|not()}
        {include uri='design:header/tools.tpl'}
    {/if}


    {if and( $pagedata.is_login_page|not(), array( 'edit', 'browse' )|contains( $ui_context )|not() )}
      <div class="Header-toggle Grid-cell">
        <a class="Hamburger-toggleContainer js-fr-offcanvas-open u-nojsDisplayInlineBlock u-lg-hidden u-md-hidden" href="#menu" aria-controls="menu" aria-label="accedi al menu" title="accedi al menu">
          <span class="Hamburger-toggle" role="presentation"></span>
          <span class="Header-toggleText" role="presentation">Menu</span>
        </a>
      </div>
    {/if}

  </div>
</div><!-- Header-navbar -->

