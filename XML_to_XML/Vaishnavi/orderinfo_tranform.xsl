<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:gf="http://mynamespace.fr/myvocabulary#"
    version="1.0">
    <!--XSLT stylesheet that extracts some information from XML, specifically the menu name, customer name, order date, delivery person name, delivery status sorted by order date:-->
    <xsl:output method="xml" indent="yes"/>

    <!-- Namespace declaration -->
    <xsl:template match="/">
        <Order_Overview xmlns:gf="http://mynamespace.fr/myvocabulary#">
            <xsl:apply-templates select="gf:GOOD_FOOD/gf:ORDERS/gf:ORDER">
                <xsl:sort select="@ondate"/>
            </xsl:apply-templates>
        </Order_Overview>
    </xsl:template>

    <xsl:template match="gf:ORDER">
        <gf:ORDERS>
            <gf:ORDER>
                <xsl:attribute name="ondate">
                    <xsl:value-of select="@ondate"/>
                </xsl:attribute>
                <gf:CUSTOMER_ORDERED>
                    <xsl:value-of select="gf:CUSTOMER_ORDERED/@c"/>:
                    <gf:ORDER_STATUS>
                        <xsl:value-of select="gf:ORDER_STATUS"/>
                    </gf:ORDER_STATUS>
                    <gf:ITEMS>
                        <gf:ITEM>
                            <xsl:value-of select="gf:CUSTOMER_ORDERED/gf:ITEMS/gf:ITEM/@m"/>
                        </gf:ITEM>
                    </gf:ITEMS>
                </gf:CUSTOMER_ORDERED>
            </gf:ORDER>
        </gf:ORDERS>
    </xsl:template>
</xsl:stylesheet>
