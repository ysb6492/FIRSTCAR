package com.nbp.cart.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.nbp.cart.model.DTO.Cart;
import com.nbp.cart.model.service.CartService;
import com.nbp.model.DTO.Member;

/**
 * Servlet implementation class MoveToCartServlet
 */
@WebServlet("/common/movetocart.do")
public class MoveToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MoveToCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Member loginMember=(Member)request.getSession().getAttribute("loginMember");
		CartService cs=new CartService();
		List<Cart> carts=cs.selectCartByMemberId(loginMember.getMemberId());
		System.out.println(carts);
		request.setAttribute("carts", carts);
		
		request.getRequestDispatcher("/WEB-INF/views/cart/Cart.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
