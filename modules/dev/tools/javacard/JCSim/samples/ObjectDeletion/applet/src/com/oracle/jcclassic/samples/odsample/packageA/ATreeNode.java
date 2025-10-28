/** 
 * Copyright (c) 1998, 2025, Oracle and/or its affiliates. All rights reserved.
 * 
 */

/*
 */

package com.oracle.jcclassic.samples.odsample.packageA;

/**
 * Class represents nodes of a binary tree.
 */

public class ATreeNode {

    ATreeNode left = null;
    ATreeNode right = null;
    private static short data;

    /**
     * Constructor. Makes children if depth of tree not reached maxdepth yet
     */
    public ATreeNode(short currDepth, short maxDepth) {
        if (currDepth < maxDepth) {
            left = new ATreeNode((short) (currDepth + 1), maxDepth);
            right = new ATreeNode((short) (currDepth + 1), maxDepth);
            this.setData((short) 0xAA);
            left.setData((short) 0xAA);
            right.setData((short) 0xAA);
        }
    }

    public static void setData(short d)
    {
        data = d;
    }

    public static short getData(short d)
    {
        return data;
    }
}
