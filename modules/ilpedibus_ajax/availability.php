<?php
	$http = eZHTTPTool::instance();
	$module = $Params['Module'];
	$tpl = eZTemplate::factory();

    $__RELATION_LIST_XML = new DOMDocument();

    $__ILPEDIBUS = eZINI::instance( 'ilpedibus.ini' );
    $__NODE_ID_AVAILABILITY = $__ILPEDIBUS->variable( 'IlPedibus','Availability' );
    $__LIMIT_AVAILABILITY = $__ILPEDIBUS->variable( 'IlPedibus','limit_availability' );

    $__PEDIBUS_CLASS_IDENTIFIER = $__ILPEDIBUS->variable( 'IlPedibus','UserPedibus' );
    $__DAY_IN_SECOND = $__ILPEDIBUS->variable( 'IlPedibus','seconds_on_day' );
    $__DAYS_MAP = $__ILPEDIBUS->variable( 'IlPedibus','days_map' );

    $__LINES_FILTER = [];

    $__CURRENT_USER = eZUser::currentUser();

    if($__CURRENT_USER->attribute( "contentobject" )->ClassIdentifier == $__PEDIBUS_CLASS_IDENTIFIER)
    {
        $__RELATION_LIST_XML->loadXML($__CURRENT_USER->attribute( "contentobject" )->DataMap()['lines_enable_to_read']->DataText);

        foreach($__RELATION_LIST_XML->getElementsByTagName('relation-list') as $__RELATION_ITEM )
        {
            foreach($__RELATION_ITEM->getElementsByTagName('relation-item') as $__RELATED_NODE )
            {
                $__LINES_FILTER[] = $__RELATED_NODE->getAttribute('node-id');
            }
        }
    }

    $__LIST_AVAILABILITY = eZContentObjectTreeNode::subTreeByNodeID(
                    [
                        'ClassFilterType' => 'include',
                        'ClassFilterArray' => array('disponibilita'),
                        'AttributeFilter' => array(
                                                    array('disponibilita/al', '>=', time())
                                            ),
                        'Limit' => $__LIMIT_AVAILABILITY
                    ],
                    $__NODE_ID_AVAILABILITY
    );

    $__LINES_STR = null;
    $__ADULTS = null;
    $__DAYS = null;
    $__SKIP_LOOP = false;
    $__RESULT = array();

    foreach($__LIST_AVAILABILITY as $__KEY => $__AVAILABILY)
    {
        $__LINES_STR = "";
        $__ADULTS = array();
        $__DAYS = array();
        $__SKIP_LOOP = false;
        $__AVAILABILY_DATAMAP = $__AVAILABILY->dataMap();

        $__RELATION_LIST_XML->loadXML($__AVAILABILY_DATAMAP['linea']->DataText);

        foreach($__RELATION_LIST_XML->getElementsByTagName('relation-list') as $__RELATION_ITEM )
        {
            foreach($__RELATION_ITEM->getElementsByTagName('relation-item') as $__RELATED_NODE)
            {
                $__NODE_ID_LINE = $__RELATED_NODE->getAttribute('node-id');

                if(count($__LINES_FILTER))
                {
                    if(!in_array($__NODE_ID_LINE, $__LINES_FILTER))
                    {
                        $__SKIP_LOOP = true;
                        break;
                    }
                }

                $__LINE  = eZContentObjectTreeNode::fetch( $__NODE_ID_LINE );

                $__LINES_STR .= $__LINE->Name.", ";

                $__LINE = null;
                unset($__LINE);
            }
        }
        $__LINES_STR = substr($__LINES_STR,0, strlen($__LINES_STR) - 2);

        if( !$__SKIP_LOOP )
        {
            $__RELATION_LIST_XML->loadXML($__AVAILABILY_DATAMAP['giorno']->DataText);

            foreach($__RELATION_LIST_XML->getElementsByTagName('relation-list') as $__RELATION_ITEM )
            {
                foreach($__RELATION_ITEM->getElementsByTagName('relation-item') as $__RELATED_NODE)
                {
                    $__NODE_ID_DAY = $__RELATED_NODE->getAttribute('node-id');

                    $__DAY = eZContentObjectTreeNode::fetch( $__NODE_ID_DAY );
                    $__DAYS[] = $__DAYS_MAP[ substr(strtolower($__DAY->Name), 0, strlen($__DAY->Name) -2) ];
                    $__DAY = null;
                    $__NODE_ID_DAY = null;
                    unset($__DAY);
                    unset($__NODE_ID_DAY);
                }
            }

            $__RELATION_LIST_XML->loadXML($__AVAILABILY_DATAMAP['volontario']->DataText);

            foreach($__RELATION_LIST_XML->getElementsByTagName('relation-list') as $__RELATION_ITEM )
            {
                foreach($__RELATION_ITEM->getElementsByTagName('relation-item') as $__RELATED_NODE)
                {
                    $__NODE_ID_ADULT = $__RELATED_NODE->getAttribute('node-id');
                    if(intval($__NODE_ID_ADULT))
                    {
                        $__ADULT = eZContentObjectTreeNode::fetch( $__NODE_ID_ADULT );

                        $__URL_ALIAS = $__ADULT->pathWithNames();
                        eZURI::transformURI($__URL_ALIAS, false, "full");

                        $__ADULTS = array_merge($__ADULTS, [$__ADULT->Name => $__URL_ALIAS]);

                        $__ADULT = null;
                        unset($__ADULT);
                    }
                    $__NODE_ID_ADULT = null;
                }
            }

            foreach( $__ADULTS as $__ADULT => $__ADULT_URI )
            {
                $__PERIOD = $__AVAILABILY_DATAMAP['dal']->DataInt;
                if($__PERIOD <= $__AVAILABILY_DATAMAP['al']->DataInt)
                {
                    $__DATETIME_PERIOD = new DateTime();
                    $__DATETIME_PERIOD->setTimestamp($__PERIOD);

                    if(in_array($__DATETIME_PERIOD->format('w'),$__DAYS))
                    {
                        $__TMP_ARRAY = [];
                        $__TMP_ARRAY['title'] = $__LINES_STR." - ".$__ADULT;
                        $__TMP_ARRAY['url'] = $__ADULT_URI;
                        $__TMP_ARRAY['start'] = $__DATETIME_PERIOD->format('Y-m-d');
                        $__TMP_ARRAY['end'] = $__DATETIME_PERIOD->format('Y-m-d');

                        $__RESULT[] = $__TMP_ARRAY;
                        $__TMP_ARRAY = null;
                        unset($__TMP_ARRAY);
                    }

                    while($__PERIOD < $__AVAILABILY_DATAMAP['al']->DataInt)
                    {
                        $__PERIOD += $__DAY_IN_SECOND;
                        $__DATETIME_PERIOD->setTimestamp($__PERIOD);

                        if(in_array($__DATETIME_PERIOD->format('w'),$__DAYS))
                        {
                            $__TMP_ARRAY = [];
                            $__TMP_ARRAY['title'] = $__LINES_STR." - ".$__ADULT;
                            $__TMP_ARRAY['url'] = $__ADULT_URI;
                            $__TMP_ARRAY['start'] = $__DATETIME_PERIOD->format('Y-m-d');
                            $__TMP_ARRAY['end'] = $__DATETIME_PERIOD->format('Y-m-d');

                            $__RESULT[] = $__TMP_ARRAY;
                            $__TMP_ARRAY = null;
                            unset($__TMP_ARRAY);
                            gc_collect_cycles();
                        }
                    }

                }//endif
            }//end foreach
        }//end if

        $__ADULTS = null;
        $__LINES_STR = null;
        $__DAYS = null;
        $__SKIP_LOOP = null;
        $__LINES_STR = "";

        unset($__ADULTS);
        unset($__LINES_STR);
        unset($__DAYS);
        unset($__SKIP_LOOP);
        unset($__LINES_STR);

        gc_collect_cycles();
    }// end for

    header('Content-type:application/json;charset=utf-8');
    echo json_encode($__RESULT);
    eZExecution::cleanExit();
?>
