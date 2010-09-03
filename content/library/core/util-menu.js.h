// ////////////////////////////////////////////////////////////////////////
//
// @file util-menu.js.h
// 
// @brief Javascript implementation of our akMenu object
//
// @details 
// This file implements the datatype and client-side handling for menu bits
//
// ////////////////////////////////////////////////////////////////////////
#ifndef UTIL_MENU_JS_H
#define UTIL_MENU_JS_H

// ////////////////////////////////////////////////////////////////////////
// Class: akMenuItem 
//
// @brief Base menuitem object, used for dynamic menu generation.
//
// @details 
// An akMenuItem object contains information about itself.
// We add members in the constructor, but use the prototype semantics
// for adding methods.
//
// The goal here is a JSON-serializable item that can be (re)loaded at any
// time.
//
// This object is used to create or fill in an LI element in the DOM
//
// @param itemId String ID of the item, used as 'id' attribute of LI object
// @param itemLabel String text to render on the menu item
// @param itemClass String class, used for styling by the skins
// @param itemURL Clicky go here...
//
function akMenuItem(itemId,itemLabel,itemClass,itemURL)
{
    /* Step 1: simple assignment of public members */
    this.id=''+itemId;
    this.itemLabel=''+itemLabel;
    this.itemClass=''+itemClass;
    this.itemURL=''+itemURL;

    /* Step 2: private members */
        /* Step 2.1: To whom are we attached? */
    this.parentId=null;
        /* Step 2.2: Id and attachment of child */
    this.childId=null;
    this.childSide='bottom';
    this.childAlign='left';

    /* Step 3: DOM references */
    this.element=null;
    this.childElement=null;
}

akMenuItem.prototype.adopt = function(menuId)
{
    this.childId=menuId; 
}

akMenuItem.prototype.setAttach = function(side,align)
{
    this.childSide=side;
    this.childAlign=align;
}

akMenuItem.prototype.hide = function()
{
    try {
        if (null==this.element) this.element=document.getElementById(this.id);
        this.element.style.display='none';
    } catch (err) { }
}

akMenuItem.prototype.show = function()
{
    try {
        if (null==this.element) this.element=document.getElementById(this.id);
        this.element.style.display='list-item';
    } catch (err) {}
}

akMenuItem.prototype.hideChild = function()
{
    try {
        if (null != this.childId) {
            if (null==this.childElement) this.childElement=document.getElementById(this.childId);
            this.childElement.style.display='none';
        }
    } catch (err) {}
}

akMenuItem.prototype.showChild = function()
{
    try {
        if (null != this.childId) {
            /* Step 1: load element cache */
            if (null==this.childElement) this.childElement=document.getElementById(this.childId);
            if (null=this.element) this.element=document.getElementById(this.id);
            /* Step 2: DOM position/display */
            this.childElement.style.display='inline';
            this.childElement.style.position='absolute';
                /* CLEAN: Need dynamic display based on attach */
            this.childElement.style.top=this.element.style.top+this.element.style.height;
        }
    } catch (err) {}
}

#endif /* UTIL_MENU_JS_H */
