<!-- XLST #2: Display menus in a table layout, complete with descriptions, and order them based on price-->

<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:gf="http://mynamespace.fr/myvocabulary#">
    <xsl:output method="html" encoding="UTF-8" />

    <xsl:template match="/">
        <html>
            <head>
                <title>
                    Menu pricing
                </title>
                <style>
                    table { width: 100%; border-collapse: collapse; }
                    th, td { border: 1px solid black; padding: 8px; text-align: left; }
                    th { background-color: #f2f2f2; }
                </style>
            </head>
            <body>
                <h1>Menu Catalogue</h1>
                <table>
                        <tr>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Price</th>
                        </tr>
                        <xsl:apply-templates select="/gf:GOOD_FOOD" />
                </table>
            </body>
        </html>
    </xsl:template>

    <!-- Template to match the root element -->
    <xsl:template match="gf:GOOD_FOOD">

        <!-- List menu as pricing -->
        <xsl:for-each select="gf:MENUS/gf:MENU">
            <xsl:sort select="gf:PRICE" data-type="number" order="descending"/>
                        <tr>
                            <td><xsl:value-of select="gf:MENU_NAME"/></td>
                            <td><xsl:value-of select="gf:DESCRIPTION"/></td>
                            <td><xsl:value-of select="gf:PRICE"/></td>
                        </tr>
        </xsl:for-each>

    </xsl:template>

</xsl:stylesheet>