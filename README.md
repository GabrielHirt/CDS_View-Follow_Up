# CDS View - Purchasing report for follow-up

## Objective and Details
- Goal: Join evevery SAP important data from purchase area to controll and following of the purchase processes </br>

- Tables Involved and Joins:</br>
EKPO (Purchase order items) – Main table for purchase order items.</br>
EKKO (Purchase order headers) – Linked by EBELN (PO number).</br>
EKET (Scheduling agreements) – Linked by EBELN and EBELP (PO item number).</br>
ZMMT0002 (Custom table) – Contains additional material data.</br>
LFA1 (Vendor master) – Provides supplier information.</br>
EBAN (Purchase requisitions) – Links requisitions to PO items.</br>
MARA (Material master) – Provides material descriptions and data.</br>
LFA1_FABRIC – Links materials to their manufacturers.</br>
EKKN (Account assignment) – Includes cost centers, orders, etc.</br>
T16FS and T16FE – Handles release strategy and status approvals.</br>
AUFK – Order master data.</br>
ZCDS_HRP1000 – Custom CDS view with workflow/HR data. </br>

## Summary:
This CDS View is designed to generate a comprehensive report on purchase orders, including: </br></br>

- Purchase item details, pricing, and status. </br>
- Vendor information and workflow status. </br>
- Quantities ordered, delivered, and yet to be invoiced. </br>
- Approval processes, release strategies, and attachments. </br></br>
The joins with various tables ensure that all relevant data—such as materials, approvals, vendors, and order statuses—are consolidated into a single report. </br> </br>
![image](https://github.com/user-attachments/assets/8fb4258b-73d8-45c1-919e-ab078cbecdaf)  </br>
Access the complete code in the attached file.



<!-- -->

## Reference
### Introduction SAP CDS View Course 
https://learning.sap.com/learning-journeys/acquire-core-abap-skills/defining-basic-cds-views_44d04348-d743-3ad4-b581-44e37262ddc3

![image](https://github.com/user-attachments/assets/501b62c3-fc70-4b89-b534-4eb4f4657f15)


