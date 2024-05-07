<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:gf="http://mynamespace.fr/myvocabulary#">
    <xsl:output method="html" encoding="UTF-8" />

    <xsl:template match="/">
        <html>
            <head>
                <title>
				    Average rating per menu
                </title>
            </head>
            <body>
                <h1>Based on our information about deliveries, average rating per menu is following</h1>
                <blockquote>
                    <xsl:apply-templates select="/gf:GOOD_FOOD" />
                </blockquote>
            </body>
        </html>
    </xsl:template>
	
	<!-- Template to match the root element -->
    <xsl:template match="gf:GOOD_FOOD">
	<table border="1">
    <tr>
      <th>Menu name:</th>
      <th>Average rating:</th>
    </tr>
		<!-- Group by gf:MENU_NAME and sum+count gf:RATED_MENU -->
		<xsl:for-each select="gf:MENUS/gf:MENU">
			<xsl:sort select="sum(../..//gf:MENU_RATINGS/gf:MENU_RATING/gf:DELIVERY/gf:RATED_MENU[@m = current()/@id])
                    div count(../..//gf:MENU_RATINGS/gf:MENU_RATING/gf:DELIVERY/gf:RATED_MENU[@m = current()/@id])"
              data-type="number" order="descending" />
			  <tr>
				<td><xsl:value-of select="gf:MENU_NAME" /></td>
				<td><xsl:value-of
                        select="sum(../..//gf:MENU_RATINGS/gf:MENU_RATING/gf:DELIVERY/gf:RATED_MENU[@m = current()/@id])
				div count(../..//gf:MENU_RATINGS/gf:MENU_RATING/gf:DELIVERY/gf:RATED_MENU[@m = current()/@id])" /></td>
			  </tr>
        </xsl:for-each>
	</table>

    </xsl:template>


</xsl:stylesheet>