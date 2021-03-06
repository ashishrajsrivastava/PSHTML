Function ol {
    <#
    .SYNOPSIS
    Create a ol tag in an HTML document.

    .EXAMPLE
    ol

    .EXAMPLE
    ol -Content {li -Content "asdf"}

    .EXAMPLE
    ol -Class "class" -Id "something" -Style "color:red;"

    .EXAMPLE

    ol {li -Content "asdf"} -reversed -type a

    #Generates the following content

    <ol type="a" reversed >
        <li>
            asdf
        </li>
    </ol>

    .NOTES
    Current version 1.1
       History:
        2018.04.14;stephanevg;fix Content bug, Added parameter 'type'. Upgraded to v1.1.
        2018.04.01;bateskevinhanevg;Creation.
    .LINK
        https://github.com/Stephanevg/PSHTML
    #>
    [CmdletBinding()]
    Param(

        [Parameter(
            ValueFromPipeline = $true,
            Mandatory = $false,
            Position = 0
        )]
        $Content,

        [Parameter(Position = 1)]
        [String]$Class,

        [Parameter(Position = 2)]
        [String]$Id,

        [Parameter(Position = 3)]
        [String]$Style,

        [Parameter(Position = 4)]
        [Hashtable]$Attributes,

        [Parameter(Position = 5)]
        [Switch]$reversed,

        [Parameter(Position = 6)]
        [int]$start,

        [ValidateSet("1","A","a","I","i")]
        [Parameter(Position = 7)]
        [String]$type


    )
    Process{

        $attr = ""
        $CommonParameters = ("Attributes", "Content","reversed") + [System.Management.Automation.PSCmdlet]::CommonParameters + [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
        $CustomParameters = $PSBoundParameters.Keys | Where-Object -FilterScript { $_ -notin $CommonParameters }

        if($CustomParameters){

            foreach ($entry in $CustomParameters){


                $Attr += "{0}=`"{1}`" " -f $entry,$PSBoundParameters[$entry]

            }

        }

        if($reversed){
            $attr += "reversed"
        }

        if($Attributes){
            foreach($entry in $Attributes.Keys){

                $attr += "{0}=`"{1}`" " -f $entry,$Attributes[$Entry]
            }
        }

        if($attr){
            "<ol {0} >"  -f $attr
        }else{
            "<ol>"
        }


        if($Content){

            if($Content -is [System.Management.Automation.ScriptBlock]){
                $Content.Invoke()
            }else{
                $Content
            }
        }


        '</ol>'
    }


}

