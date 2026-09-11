pageextension 50113 MyCustomersExtension extends "My Customers"
{
    layout
    {
        addafter(Name)
        {

            field("Contact";Customer.Contact)
            {
                ToolTip = 'Contact';
            }
            field("N° téléphone Contact";Customer."Phone No.")
            {
                ToolTip = 'N° téléphone Contact';
            }
            field("N° portable Contact";Customer."Mobile Phone No.")
            {
                ToolTip = 'N° portable contact';
            }
            field("Mail contact";Customer."E-Mail")
            {
                ToolTip = 'Mail Contact';
            }
        }
    }
    actions
    {

    }

}
