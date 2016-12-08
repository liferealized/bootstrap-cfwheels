component mixin="controller" dependency="NestedErrorMessageOn" output="false" {

  //   8888888b.           888      888 d8b
  //   888   Y88b          888      888 Y8P
  //   888    888          888      888
  //   888   d88P 888  888 88888b.  888 888  .d8888b
  //   8888888P"  888  888 888 "88b 888 888 d88P"
  //   888        888  888 888  888 888 888 888
  //   888        Y88b 888 888 d88P 888 888 Y88b.
  //   888         "Y88888 88888P"  888 888  "Y8888P
  // Public

  public Bootstrap function init() {
    this.version = "2.0";
    return this;
  }

  //
  //   8888888888                                              88888888888
  //   888                                                         888
  //   888                                                         888
  //   8888888  .d88b.  888d888 88888b.d88b.                       888   8888b.   .d88b.
  //   888     d88""88b 888P"   888 "888 "88b                      888      "88b d88P"88b
  //   888     888  888 888     888  888  888      888888          888  .d888888 888  888
  //   888     Y88..88P 888     888  888  888                      888  888  888 Y88b 888
  //   888      "Y88P"  888     888  888  888                      888  "Y888888  "Y88888
  //                                                                                  888
  //                                                                             Y8b d88P
  //                                                                              "Y88P"
  // Form - tag helpers

  public string function submitTag(string class = "", boolean isPrimary = false) {

    local.class = listAppend(arguments.class, "btn", " ");
    local.isPrimary = arguments.isPrimary;

    StructDelete(arguments, "isPrimary");
    StructDelete(arguments, "class");

    if (local.isPrimary)
      local.class = listAppend(local.class, "btn-primary", " ");

    local.rv = core.submitTag(argumentCollection=arguments);
    local.rv = replaceNoCase(
      local.rv,
      "<input",
      "<input class=""#local.class#"""
    );

    return
      '<div class="form-group">
        <div class="col-sm-offset-3 col-sm-9">
          #local.rv#
        </div>
      </div>';
  }

  public string function startFormTag(string class = "") {
    arguments.class = ListAppend(arguments.class, "form-horizontal", " ");
    return core.startFormTag(argumentCollection = arguments);
  }

  //   8888888888                                               .d88888b.  888       d8b                   888
  //   888                                                     d88P" "Y88b 888       Y8P                   888
  //   888                                                     888     888 888                             888
  //   8888888  .d88b.  888d888 88888b.d88b.                   888     888 88888b.  8888  .d88b.   .d8888b 888888
  //   888     d88""88b 888P"   888 "888 "88b                  888     888 888 "88b "888 d8P  Y8b d88P"    888
  //   888     888  888 888     888  888  888      888888      888     888 888  888  888 88888888 888      888
  //   888     Y88..88P 888     888  888  888                  Y88b. .d88P 888 d88P  888 Y8b.     Y88b.    Y88b.
  //   888      "Y88P"  888     888  888  888                   "Y88888P"  88888P"   888  "Y8888   "Y8888P  "Y888
  //                                                                                 888
  //                                                                                d88P
  //                                                                              888P"
  // Form - object helpers

  public string function checkBox() {

    local.checkBox = core.checkBox(
      argumentCollection = arguments,
      labelPlacement = "around"
    );

    local.hasErrors = $formHasError(argumentCollection=arguments);

    local.checkBox =
      '<div class="form-group #local.hasErrors ? 'has-error': ''#">
        <div class="col-sm-offset-2 col-sm-10">
          <div class="checkbox">
            #local.checkBox#
          </div>
        </div>
      </div>';

    return local.checkBox;
  }

  public string function fileField() {
    arguments = $boostrapObjectFormFieldArgs(argumentCollection = arguments);
    return core.fileField(argumentCollection = arguments);
  }

  public string function passwordField() {
    arguments = $boostrapObjectFormFieldArgs(argumentCollection = arguments);
    return core.passwordField(argumentCollection = arguments);
  }

  public string function select() {
    arguments = $boostrapObjectFormFieldArgs(argumentCollection = arguments);
    return core.select(argumentCollection = arguments);
  }

  public string function textArea() {
    arguments = $boostrapObjectFormFieldArgs(argumentCollection = arguments);
    return core.textArea(argumentCollection = arguments);
  }

  public string function textField() {
    arguments = $boostrapObjectFormFieldArgs(argumentCollection = arguments);
    return core.textField(argumentCollection = arguments);
  }

  //   888                                          888
  //   888                                          888
  //   888                                          888
  //   888       8888b.  888  888  .d88b.  888  888 888888
  //   888          "88b 888  888 d88""88b 888  888 888
  //   888      .d888888 888  888 888  888 888  888 888
  //   888      888  888 Y88b 888 Y88..88P Y88b 888 Y88b.
  //   88888888 "Y888888  "Y88888  "Y88P"   "Y88888  "Y888
  //                          888
  //                     Y8b d88P
  //                      "Y88P"
  // Layout helpers

  public string function flashMessages() {

    local.rv = "";
    local.keys = structKeyList(flash());

    if (flashCount()) {
      for (local.i = 1; local.i <= flashCount(); local.i++)
      {
        local.flashKey = ListGetAt(local.flashKeyList, local.i);

        local.rv &=
          '<div class="alert alert-dismissible alert-#LCase(local.flashKey)#">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
            <a class="close" data-dismiss="alert" href="##" title="Dismiss">&times;</a>
            <strong>#capitalize(local.flashKey)#!</strong> #h(flash(local.flashKey))#
          </div>';
      }

      return local.rv;
    }
  }

  //   888b     d888 d8b
  //   8888b   d8888 Y8P
  //   88888b.d88888
  //   888Y88888P888 888 .d8888b   .d8888b
  //   888 Y888P 888 888 88K      d88P"
  //   888  Y8P  888 888 "Y8888b. 888
  //   888   "   888 888      X88 Y88b.
  //   888       888 888  88888P'  "Y8888P
  // Miscellaneous helpers

  public string function paginationLinks() {

    arguments.prepend = '<ul class="pagination">';
    arguments.append = '</ul>';
    arguments.prependToPage = '<li>';
    arguments.appendToPage = '</li>';
    arguments.classForCurrent = "active";
    arguments.linkToCurrentPage = false;
    arguments.anchorDivider = "";
    arguments.linkToCurrentPage = true;

    local.rv = core.paginationLinks(argumentCollection=arguments);

    return replace(
      local.rv,
      '<li><a class="active"',
      '<li class="active"><a', "all"
    );
  }

  //   8888888b.          d8b                   888
  //   888   Y88b         Y8P                   888
  //   888    888                               888
  //   888   d88P 888d888 888 888  888  8888b.  888888 .d88b.
  //   8888888P"  888P"   888 888  888     "88b 888   d8P  Y8b
  //   888        888     888 Y88  88P .d888888 888   88888888
  //   888        888     888  Y8bd8P  888  888 Y88b. Y8b.
  //   888        888     888   Y88P   "Y888888  "Y888 "Y8888
  // Private

  public struct function $bootstrapFormFieldArgs() {

    if (!structKeyExists(arguments, "labelClass"))
      arguments.labelClass = "";

    if (!structKeyExists(arguments, "class"))
      arguments.class = "";

    arguments.labelPlacement = "before";
    arguments.class = listAppend(arguments.class, "form-control", " ");
    arguments.labelClass = listAppend(arguments.labelClass, "col-sm-3 control-label", " ");
    arguments.prepend = '<div class="col-sm-9 input-group">';
    arguments.prependToLabel = '<div class="form-group">';
    arguments.append = '</div></div>';
    arguments.errorElement = "";
    arguments.errorClass = "";

    // Prepend/appended text
    local.hasPrependedText = StructKeyExists(arguments, "prependedText") && Len(arguments.prependedText);
    local.hasAppendedText = StructKeyExists(arguments, "appendedText") && Len(arguments.appendedText);

    if (local.hasPrependedText || local.hasAppendedText)
    {
      if (local.hasPrependedText)
        arguments.prepend &= '<span class="input-group-addon">#arguments.prependedText#</span>';

      if (local.hasAppendedText)
        arguments.append =
          '<span class="input-group-addon">#arguments.appendedText#</span>'
          & arguments.append;
    }

    // Help block
    if (StructKeyExists(arguments, "helpBlock") && Len(arguments.helpBlock))
      arguments.append = '<p class="help-block">#arguments.helpBlock#</p>'
        & arguments.append;

    // Remove arguments that will cause extra HTML attributes to be added
    StructDelete(arguments, "helpBlock");
    StructDelete(arguments, "prependedText");
    StructDelete(arguments, "appendedText");

    return arguments;
  }

  public struct function $boostrapObjectFormFieldArgs() {

    // Get basic settings from general form field helper
    arguments = $bootstrapFormFieldArgs(argumentCollection = arguments);

    // Arguments needed for `errorMessageOn`
    local.errorMessageOnArgs = {
      objectName=arguments.objectName,
      property=arguments.property,
      wrapperElement="span",
      class="help-inline"
    };

    if (StructKeyExists(arguments, "association"))
      local.errorMessageOnArgs.association = arguments.association;

    if (StructKeyExists(arguments, "position"))
      local.errorMessageOnArgs.position = arguments.position;

    // Error message
    if ($formHasError(argumentCollection=arguments))
    {
      arguments.prependToLabel = Replace(
        arguments.prependToLabel,
        '<div class="control-group">',
        '<div class="control-group error">'
      );

      arguments.append =
        ' #errorMessageOn(argumentCollection=local.errorMessageOnArgs)#'
        & arguments.append;
    }

    return arguments;
  }
}
