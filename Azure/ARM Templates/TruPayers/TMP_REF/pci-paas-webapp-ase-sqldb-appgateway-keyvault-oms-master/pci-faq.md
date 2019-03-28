# FAQ and troubleshooting

### Why am I unable to login or run the PowerShell scripts with my Azure subscription user? 
> You are required to create an Azure Active Directory (AAD) administrator as specified in the document. This is required because a subscription admin does not automatically receive DS or AAD credentials. This is a security feature that enables RBAC and role separation in Azure.

### Why do I need to add my subscription administrator to the AAD Admin role?
> Role-based access control requires that an administrator be granted administrative rights in AAD. For a detailed explanation, see:
- [Delegating Admin Rights in Microsoft Azure](https://www.petri.com/delegating-admin-rights-in-microsoft-azure)
- [PowerShell - Connecting to Azure Active Directory using Microsoft Account](http://stackoverflow.com/questions/29485364/powershell-connecting-to-azure-active-directory-using-microsoft-account)

### What should I do if my SSL .pxf files are not working?
> For more information, see:
- [How to install a SSL certification on Azure](https://www.ssl.com/how-to/install-a-ssl-certificate-on-a-microsoft-azure-web-appwebsite-and-cloud-service/)
- [Web sites configuring SSL certificate](https://docs.microsoft.com/en-us/azure/app-service-web/web-sites-configure-ssl-certificate)

### Why is a paid Azure account required to use this solution?
> Many of the features used in the solution are not available in an Azure trial account. You will also require access to manage the subscription as a [Subscription Admins role and co-administrator of the subscription](https://docs.microsoft.com/en-us/azure/active-directory/active-directory-assign-admin-roles#global-administrator).

### Why do I need an SSL certificate?
> The installation requires a custom domain and SSL certificate to meet PCI DSS requirements and protect the client-side traffic from snooping. Microsoft recommends that a custom domain be purchased with [an SSL package](https://d.docs.live.net/7b2b5032e10686e1/Azure%20Compliance/PCI%20DSS%20quickstart/1.%09https:/docs.microsoft.com/en-us/azure/app-service-web/web-sites-purchase-ssl-web-site). Microsoft offers the ability to create a domain and request an SSL certificate from a Microsoft partner.

### How do I set up the administrator properly to use this solution?
> Review the 'Configure your global admin for the solution' section of the installation guide.

### Why does the ARM template fail to run because of my password complexity?
> Strong passwords (minimum 15 characters, with upper and lower-case letters, at least 1 number, and 1 special character) are recommended throughout the solution.

### Why does the ARM template fail to deploy a specific service?
> Currently this solution requires that you deploy in US EAST. Limitations of service availability in all regions may prevent the solution from deploying storage accounts, or the AES. Though a service may be deploying correctly through the templates, it may not be readily available during provisioning, which can result in false-positive errors in the deployment scripts. It is recommended to review messages in the Azure portal along with messages received in the PowerShell console. This solution was tested with the following resource group command: `New-AzureRmResourceGroup -Name [RESOURCE GROUP NAME] -Location "East US"`

### Why does the ARM template fail to update the SQL database after it is deployed?
> When redeploying either the pilot solution or the Contoso Web Store example, it is recommended that users clean up all assets created by previous deployments through these scripts. These scripts will run through automated creation of service and user accounts for supporting the deployment, and credential conflicts may be encountered if these users are not cleaned up prior to reattempting the deployment. 

### Why does the Bastion VM fail to deploy in the templates?
> During the BitLocker encryption steps of the deployment, for securing the Bastion VM, there is a known issue where the template will fail due to the VM being inaccessible during the encryption process. If experienced, a new Bastion VM can be deployed manually. If this is experienced, it is recommended to clean up previously deployed resources and attempt a new deployment. This experience is improving in Azure, but may occur while deploying the solution. 

### The deployment of my services takes over two hours. Is this normal?
> The total time for deployment of the services is approximately 1.5 hours from the time **Purchase** is clicked on the ARM template. ASE takes 2 hours to provision. For more information, see: [How to deploy ASE](http://www.bizbert.com/bizbert/2016/01/07/AppServiceEnvironmentsHowToDeployAPIAppsToAVirtualNetwork.aspx). ASE may time out in the deployment, if running for 3+ hours, in which it is recommended users cancel the deployment, clean-up deployed assets, and attempt to redeploy the solution.  

### How do I use this solution in my production deployment environment?
> This solution (including the scripts, template, and documentation) is designed to help you build a pilot or demo site. Using this solution does not provide a ready-to-production solution for customers; it only illustrates the components required to build a secure and compliant end-to-end solution. For example, custom host names, SSL certificates, virtual network address spacing, NSG routing, existing Storage and databases, existing enterprise-wide OMS workspaces and solutions, Azure Key Vault rotation policies, usage of existing AD admins and RBAC roles, and usage of existing AD applications and service principals will require customization to meet the requirements of your custom solution in production.
> The `1A-ContosoWebStoreDemoAzureResources.ps1` script (and associated scripts) can be used for fully deploying the demo solution to understand the components required for supporting a PCI-DSS compliant environment for payment processing. 
> The `1-DeployAndConfigureAzureResources.ps1` script (and associated scripts) can be used for piloting the start of building a production environment for supporting PCI-DSS compliance for payment processing. 
> NOTE: This script, independently, will not be able to provide a ready-to-production solution as configurational differences will need to be addressed, depending on the payment processing application utilized. 

### The scripts fail with a permission error. What do I do next?
> The following logins should be tested whenever you restart your PowerShell session. This may not always be necessary, but it is strongly recommended to ensure the correct credentials are cached in your new session. At all times for this demo, log in as the **admin** user in our example.  
1. Connect to your [Azure AD service](https://docs.microsoft.com/en-us/powershell/module/azuread/connect-azuread?view=azureadps-2.0)  by running the following command as your admin user (such as admin\@contosowebstore.com).
```powershell
    Connect-AzureAD
```
2. [Connect to your Azure Active Directory](https://docs.microsoft.com/en-us/powershell/module/msonline/connect-msolservice?view=azureadps-1.0) by running the following command as your admin user (such as admin\@contosowebstore.com).
```powershell
    Connect-MsolService
```
3.  [Connect to Azure Resource Manager](https://msdn.microsoft.com/en-us/library/mt125356.aspx) by running the following command as your admin user (such as admin\@contosowebstore.com).
```powershell
    Login-AzureRmAccount
```
4.  Retrieve your subscription information running the following command.
```powershell
    Get-AzureRmSubscription
```

### What else should I consider once the solution is installed?
> Once the script has completed, you should consider resetting your administrative passwords, including your ADsqladmin and Admin users. The following command can be used to quickly reset passwords in PowerShell. 

```powershell
Set-MsolUserPassword -userPrincipalName [sqladmin@yourdomain] -NewPassword [NEWPASSWORD] -ForceChangePassword $false
```

### When I run the scripts, I receive the following error: "New-Alias : The alias is not allowed, because an alias with the name 'Login-AzureRmAccount' already exists."  How do I correct this?
> This error is related to conflicting PowerShell modules. To correct this, uninstall all PowerShell MSI and modules. 

### Are there third-party solutions that can help achieve or manage PCI compliance?
> Third-party products can help with continuous compliance efforts. Examples of the products available in the Azure marketplace are listed below.

| Security Layer | Azure Marketplace Product(s) |
| --- | --- |
| Continuous Compliance Monitoring | [CloudNeeti - Continuous Governance of Azure Assets](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/cloudneeti.cloudneeti_enterpise?tab=Overview) |
| Network Security and Management | [Azure Marketplace: Network Security](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/category/networking?page=1) |
| Extending Identity Security | [Azure Marketplace: Security + Identity](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/category/security-identity?page=1) |
| Extending Monitoring and Diagnostics 	| [Azure Marketplace: Monitoring + Diagnostics](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/category/monitoring-management?page=1&subcategories=monitoring-diagnostics) |
