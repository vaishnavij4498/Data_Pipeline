<!-- XLST #2: Catalogue each menu, specifying names, ingredients, and pricing details-->

<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:gf="http://mynamespace.fr/myvocabulary#">
    <xsl:output method="html" encoding="UTF-8" />

    <xsl:template match="/">
        <html>
            <head>
                <title>
                    Menu list
                </title>
            </head>
            <body>
                <h1>Our Menu</h1>
                <blockquote>
                    <xsl:apply-templates select="/gf:GOOD_FOOD" />
                </blockquote>
            </body>
        </html>
    </xsl:template>

    <!-- Template to match the root element -->
    <xsl:template match="gf:GOOD_FOOD">

        <!-- Catalogue each menu, specifying names, ingredients, and pricing details -->
        <xsl:for-each select="gf:MENUS/gf:MENU">
           <div class="menu">
                        <h2><xsl:value-of select="gf:MENU_NAME"/></h2>
                        <p><xsl:value-of select="gf:DESCRIPTION"/></p>
                        <h3>Ingredients:</h3>
                        <ul>
                            <xsl:for-each select="gf:INGREDIENTS/gf:INGREDIENT">
                                <li><xsl:value-of select="."/></li>
                            </xsl:for-each>
                        </ul>
                        <p>Price: <xsl:value-of select="gf:PRICE"/> USD</p>
            </div>
        </xsl:for-each>

    </xsl:template>

</xsl:stylesheet>