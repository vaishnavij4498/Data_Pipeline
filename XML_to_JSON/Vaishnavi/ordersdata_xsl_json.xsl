<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:gf="http://mynamespace.fr/myvocabulary#">
    <xsl:output method="text" encoding="UTF-8" indent="yes"/>

    <!-- Match the root element -->
    <xsl:template match="/">
        {
            "orders": [
                <xsl:apply-templates select="gf:GOOD_FOOD/gf:ORDERS/gf:ORDER"/>
            ]
        }
    </xsl:template>

    <!-- Match the ORDER element -->
    <xsl:template match="gf:ORDER">
        {
            "id": "<xsl:value-of select="@id"/>",
            "customer_ordered": {
                "c": "<xsl:value-of select="gf:CUSTOMER_ORDERED/@c"/>",
                "order_date": "<xsl:value-of select="gf:CUSTOMER_ORDERED/gf:ORDER_DATE"/>",
                "status": "<xsl:value-of select="gf:CUSTOMER_ORDERED/gf:ORDER_STATUS"/>",
                "items": [
                    <xsl:apply-templates select="gf:CUSTOMER_ORDERED/gf:ITEMS/gf:ITEM"/>
                ]
            }
        }
        <!-- Add comma if not the last item -->
        <xsl:if test="position() != last()">,</xsl:if>
    </xsl:template>

    <!-- Match the ITEM element -->
    <xsl:template match="gf:ITEM">
        {
            "m": "<xsl:value-of select="@m"/>",
            "quantity": "<xsl:value-of select="gf:ORDER_QUANTITY"/>"
        }
        <!-- Add comma if not the last item -->
        <xsl:if test="position() != last()">,</xsl:if>
    </xsl:template>

</xsl:stylesheet>
