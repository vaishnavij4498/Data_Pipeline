<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:gf="http://mynamespace.fr/myvocabulary#">
    <xsl:output method="html" encoding="UTF-8" />

    <xsl:template match="/">
        <html>
            <head>
                <title>
                    Sum of order quantity by menu
                </title>
            </head>
            <body>
                <h1>Based on our sales, this is the sum of ordered quantity by menu from the highest
        to lowest</h1>
                <blockquote>
                    <xsl:apply-templates select="/gf:GOOD_FOOD" />
                </blockquote>
            </body>
        </html>
    </xsl:template>

    <!-- Template to match the root element -->
    <xsl:template match="gf:GOOD_FOOD">

        <!-- Group by gf:MENU_NAME and sum gf:ORDER_QUANTITY -->
        <xsl:for-each select="gf:MENUS/gf:MENU">
            <xsl:sort
                select="sum(../..//gf:ORDERS/gf:ORDER/gf:CUSTOMER_ORDERED/gf:ITEMS/gf:ITEM[@m = current()/@id]/gf:ORDER_QUANTITY)"
                data-type="number" order="descending" />
            <ul>
                <li> Menu name: <xsl:value-of select="gf:MENU_NAME" />
                </li>
                <li> Ordered Quantity: <xsl:value-of
                        select="sum(../..//gf:ORDERS/gf:ORDER/gf:CUSTOMER_ORDERED/gf:ITEMS/gf:ITEM[@m = current()/@id]/gf:ORDER_QUANTITY)" />
        pcs </li>
            </ul>
        </xsl:for-each>

    </xsl:template>


</xsl:stylesheet>