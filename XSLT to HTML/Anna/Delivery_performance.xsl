<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:gf="http://mynamespace.fr/myvocabulary#">
    <xsl:output method="html" encoding="UTF-8" />

    <xsl:template match="/">
        <html>
            <head>
                <title>
				    Performance for each courir
                </title>
            </head>
            <body>
                <h1>Based on amount of succesfully delivered orders comparing to the total amount of orders to be delivered courirs' performance is following</h1>
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
      <th>Person name</th>
      <th>Performance, %</th>
    </tr>
        <!-- Group by gf:COURIR and sum gf:DELIVERY_STATUS -->
        <xsl:for-each select="gf:DELIVERY_PEOPLE/gf:DELIVERY_PERSON">
            <xsl:sort
                select="count(../..//gf:DELIVERY_ORDERS/gf:DELIVERY_ORDER/gf:ORDER_DELIVERED/gf:COURIR[@dp = current()/@id]/gf:DELIVERY_STATUS[. =1]) 
				div count(../..//gf:DELIVERY_ORDERS/gf:DELIVERY_ORDER/gf:ORDER_DELIVERED/gf:COURIR[@dp = current()/@id]/gf:DELIVERY_STATUS)*100"
                data-type="number" order="descending" />
            <tr>
                <td><xsl:value-of select="gf:DELIVERY_PERSON_FNAME" /></td>
                <td><xsl:value-of
                        select="count(../..//gf:DELIVERY_ORDERS/gf:DELIVERY_ORDER/gf:ORDER_DELIVERED/gf:COURIR[@dp = current()/@id]/gf:DELIVERY_STATUS[. =1]) 
				div count(../..//gf:DELIVERY_ORDERS/gf:DELIVERY_ORDER/gf:ORDER_DELIVERED/gf:COURIR[@dp = current()/@id]/gf:DELIVERY_STATUS)*100" />
        </td>
            </tr>
        </xsl:for-each>
	</table>
    </xsl:template>


</xsl:stylesheet>