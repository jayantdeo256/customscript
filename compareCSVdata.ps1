<#Here is the scenario I am facing:

We have a CSV file that was exported from the customer's existing system. The layout is:

SYSPARTNBR	PARTNBR	DESCRIPTION	STANDARDCOST	LEVEL1PRICE	VENDOR
6441	86a25	ELBOW 1/4" OD X 1/8" MPT X 90-DEG	5.022	8.37	58
271	00026133 W	RING-PISTON 8" LUBE	114.498	190.83	58
The updated pricing file is coming from there vendor and has the following layout:

PARTNBR	DESCRIPTION	LEVEL1PRICE
00001143 SP	KEY	281.54
00001236 SP	KEY	309.01
We need to compare the files and for each PARTNBR that matches, 
we need to update the LEVEL1PRICE from the vendor file into the customer's file. 
We also have to calculate the STANDARDCOST (LEVEL1PRICE * .60) and update that in the customer's file. 
For those that don't match, we need to leave the entry alone. So, the only items in the customer file that will be changed are those that match PARTNBR.
I am putting the code I have now in there. Any help would be GREATLY appreciated.
#>


$Customer =Import-Csv .\Customer.csv -Delimiter &quot;`t&quot;
$Vendor = Import-Csv .\Vendor.csv -Delimiter &quot;`t&quot;
ForEach($Entry in $Vendor)
{
        If($Customer.PARTNBR.Contains($Entry.PARTNBR))
        {
                $Index = $Customer.PARTNBR.IndexOf($Entry.PARTNBR)
                $Customer[$Index].LEVEL1PRICE = $Entry.LEVEL1PRICE
                $Customer[$Index].STANDARDCOST = [math]::Round(([decimal]$Entry.LEVEL1PRICE * .60),2)
        }
}
$Customer | Export-Csv -Path .\Customver_Updated.csv -NoTypeInformation -Delimiter
