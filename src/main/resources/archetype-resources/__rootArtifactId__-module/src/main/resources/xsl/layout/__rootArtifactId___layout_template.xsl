<?xml version="1.0" encoding="utf-8"?>
<!-- ============================================== -->
<!-- $Revision$ $Date$ -->
<!-- ============================================== -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:basket="xalan://org.mycore.frontend.basket.MCRBasketManager"
                xmlns:mcr="http://www.mycore.org/" xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
                xmlns:mcrver="xalan://org.mycore.common.MCRCoreVersion"
                xmlns:mcrxsl="xalan://org.mycore.common.xml.MCRXMLFunctions"
                version="1.0"
                exclude-result-prefixes="xlink basket mcr mcrver mcrxsl i18n">

  <xsl:import href="resource:xsl/layout/common-layout.xsl"/>

  <xsl:output method="html" doctype-system="about:legacy-compat" indent="yes" omit-xml-declaration="yes"
              media-type="text/html"
              version="5"/>
  <xsl:strip-space elements="*"/>

  <!-- Various versions -->
  <xsl:variable name="bootstrap.version" select="'4.3.1'"/>
  <xsl:variable name="fontawesome.version" select="'5.10.1'"/>
  <xsl:variable name="jquery.version" select="'3.1.1'"/>
  <xsl:variable name="jquery.migrate.version" select="'1.4.1'"/>
  <!-- End of various versions -->
  <xsl:variable name="PageTitle" select="/*/@title"/>

  <xsl:template match="/site">
    <html lang="{$CurrentLang}" class="no-js">
      <head>
        <meta charset="utf-8"/>
        <title>
          <xsl:value-of select="$PageTitle"/>
        </title>
        <xsl:comment>
          Mobile viewport optimization
        </xsl:comment>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

        <link href="{$WebApplicationBaseURL}webjars/font-awesome/{$fontawesome.version}/css/all.min.css" rel="stylesheet" />
        <link href="{$WebApplicationBaseURL}rsc/sass/scss/bootstrap-${rootArtifactId}.css" rel="stylesheet" />
        <script type="text/javascript" src="{$WebApplicationBaseURL}webjars/jquery/{$jquery.version}/jquery.min.js"></script>
        <script type="text/javascript" src="{$WebApplicationBaseURL}webjars/jquery-migrate/{$jquery.migrate.version}/jquery-migrate.min.js"></script>

        <xsl:copy-of select="head/*" />
      </head>

      <body>

        <header>
            <xsl:call-template name="navigation" />
        </header>

        <div class="container my-5" id="page">
          <xsl:call-template name="print.writeProtectionMessage"/>
          <xsl:choose>
            <xsl:when test="$readAccess='true'">
              <xsl:copy-of select="*[not(name()='head')]"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:call-template name="printNotLoggedIn"/>
            </xsl:otherwise>
          </xsl:choose>
        </div>

        <footer class="panel-footer" role="contentinfo">
          <div class="container">
            <div class="row">
              <div class="col-12 col-sm-6 col-md-4">
                <h5>Über uns</h5>
                <p>
                  Lorem ipsum dolor sit amet, consetetur sadipscing
                  elitr, sed diam nonumy eirmod tempor invidunt ut
                  labore et dolore magna aliquyam erat, sed diam voluptua.
                  <span class="read_more">
                    <a href="#">Mehr erfahren ...</a>
                  </span>
                </p>
              </div>
              <div class="col-6 col-sm-3 col-md-2">
                <h5>Navigation</h5>
                <ul class="nav internal_links">
                  <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='brand']/*"/>
                </ul>
              </div>
              <div class="col-6 col-sm-3 col-md-2">
                <h5>Netzwerke</h5>
                <ul class="nav social_links">
                  <li class="nav-link">
                    <a class="nav-item" href="#"><span class="fab fa-facebook"></span> Facebook
                    </a>
                  </li>
                  <li class="nav-link">
                    <a class="nav-item" href="#"><span class="fab fa-twitter"></span> Twitter
                    </a>
                  </li>
                  <li class="nav-link">
                    <a class="nav-item" href="#"><span class="fab fa-google-plus"></span> Google+
                    </a>
                  </li>
                </ul>
              </div>
              <div class="col-6 col-sm-3 col-md-2">
                <h5>Layout based on</h5>
                <ul class="nav internal_links">
                  <li>
                    <a href="http://getbootstrap.com/">Bootstrap</a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </footer>


        <xsl:variable name="mcr_version" select="concat('MyCoRe ',mcrver:getCompleteVersion())" />
        <div id="powered_by" class="text-center">
          <a href="http://www.mycore.de">
            <img src="{$WebApplicationBaseURL}content/images/mycore_logo_powered_120x30_blaue_schrift_frei.png" title="{$mcr_version}" alt="powered by MyCoRe" />
          </a>
        </div>

        <script type="text/javascript">
          <!-- Bootstrap & Query-Ui button conflict workaround  -->
          if (jQuery.fn.button){jQuery.fn.btn = jQuery.fn.button.noConflict();}
        </script>
        <script type="text/javascript" src="{$WebApplicationBaseURL}webjars/bootstrap/{$bootstrap.version}/js/bootstrap.bundle.min.js"></script>
        <script>

         $(document).ready(function(){
         $('[data-toggle="tooltip"]').tooltip();
         });

          $( document ).ready(function() {
            $('.overtext').tooltip();
            $.confirm.options = {
              text: "<xsl:value-of select="i18n:translate('confirm.text')" />",
              title: "<xsl:value-of select="i18n:translate('confirm.title')" />",
              confirmButton: "<xsl:value-of select="i18n:translate('confirm.confirmButton')" />",
              cancelButton: "<xsl:value-of select="i18n:translate('confirm.cancelButton')" />",
              post: false
            }
          });
        </script>
       </body>
    </html>
  </xsl:template>


  <!-- create navigation -->
  <xsl:template name="navigation">

    <div id="header_box" class="clearfix container">
      <div style="font-size:200%;margin:6px" id="project_logo_box">
        <a href="{concat($WebApplicationBaseURL,substring($loaded_navigation_xml/@hrefStartingPage,2),$HttpSession)}">
          <img style="height:40px;margin-right:10px" alt="Skeleton"
               src="{$WebApplicationBaseURL}content/images/skeleton.png"/>
          ${projectName} (created by <a href="https://github.com/MyCoRe-Org/mycore-skeleton-archetype">mycore-skeleton-archetype</a>)
        </a>
      </div>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="navbar navbar-expand-lg navbar-light bg-light">
      <div class="container">

        <div class="navbar-brand">
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target=".main-nav-entries">
            <span class="navbar-toggler-icon"></span>
          </button>
        </div>

        <div class="main-nav-entries collapse navbar-collapse">
          <ul class="navbar-nav">
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='search']"/>
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='browse']"/>
            <xsl:apply-templates select="$loaded_navigation_xml/menu[@id='publish']"/>
          </ul>
          <ul class="navbar-nav ml-auto">
            <xsl:call-template name="loginMenu"/>
            <xsl:call-template name="languageMenu"/>
          </ul>
        </div>

        <form action="{$WebApplicationBaseURL}servlets/solr/select?q={0}" class="form-inline my-2 my-lg-0"
              role="search">
          <div class="form-group">
            <input name="q" placeholder="Suche" class="form-control mr-sm-2 search-query" id="searchInput"
                   type="text"/>
          </div>
          <button type="submit" class="btn btn-outline-success my-2 my-sm-0">
            <i class="fa fa-search"></i>
          </button>
        </form>

      </div><!-- /container -->
    </div>
  </xsl:template>

</xsl:stylesheet>