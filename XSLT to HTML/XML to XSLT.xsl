<!-- XLST #1: Catalogue each menu, specifying names, ingredients, and pricing details (Candy)-->
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:gf="http://mynamespace.fr/myvocabulary#">

    <xsl:output method="html" encoding="UTF-8"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Menu List</title>
            </head>
            <body>
                <h1>Our Menus</h1>
                <xsl:for-each select="gf:GOOD_FOOD/gf:MENUS/gf:MENU">
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
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>

<!-- XLST #2: Display menus in a table layout, complete with descriptions, and order them based on price (Candy)-->
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:gf="http://mynamespace.fr/myvocabulary#">
    <xsl:output method="html" encoding="UTF-8"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Menu Catalog</title>
                <style>
                    table { width: 100%; border-collapse: collapse; }
                    th, td { border: 1px solid black; padding: 8px; text-align: left; }
                    th { background-color: #f2f2f2; }
                </style>
            </head>
            <body>
                <h2>Menu List</h2>
                <table>
                    <tr>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                    </tr>
                    <xsl:for-each select="gf:GOOD_FOOD/gf:MENUS/gf:MENU">
                        <xsl:sort select="gf:PRICE" data-type="number" order="descending"/>
                        <tr>
                            <td><xsl:value-of select="gf:MENU_NAME"/></td>
                            <td><xsl:value-of select="gf:DESCRIPTION"/></td>
                            <td><xsl:value-of select="gf:PRICE"/></td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>

<!-- XLST #3: Determine which menu item is most frequently ordered (Dio)-->

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

<!-- XLST #4: Compute the mean rating assigned to each menu (Anna)-->
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

<!-- XLST #5: Evaluate delivery staff efficiency through metrics of successfully completed deliveries and overall transaction value(Anna)-->
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