Dash = this.Dash || {};
Dash.Dashboard = function() {
                 
    function getWidgets(uri) {
        $.ajax(uri, {
            dataType: 'json',
            success: function(data) {
                createGrid(data);
            }
        });    
    }
                
    function createGrid(widgets) {
        $('.gridster ul').remove();
        $('.gridster').append(ich.widgetTemplate({
            widgets: widgets
        }));
        $(".gridster ul").gridster({
            widget_margins: [10, 10],
            widget_base_dimensions: [140, 140]
        });                    
    }

    return {
        getWidgets: getWidgets
    };
    
};
